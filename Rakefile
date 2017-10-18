require 'pathname'
require 'fileutils'

begin
  require 'awesome_print' 
rescue LoadError
  # no colors
  class String
    def red; self; end
    def yellow; self; end
  end
end

def error! msg
  STDERR.puts msg.red
  exit 1
end

IGNORES = [
  /\.swp$/i,
  /\.tmp$/i,
  /Rakefile/,
  /\.gitmodules$/, # GIT submodules
  /\.git$/         # .git subdir with repo info
]

task :default => :install

def show_diff f1, f2
  system "colordiff", "-u", f1.to_s, f2.to_s
  if $?.exitstatus == 127
    # not found
    system "diff", "-u", f1.to_s, f2.to_s
  end
end

def ask title, answers, default = nil
  loop do
    print "#{title} ".yellow
    answer = gets.strip
    return default if default && answer == '' 
    return answer.to_sym if answers.include?(answer.to_sym)
  end
end

# our clone of "git submodule" functionality
def process_git_dot fname
  base = File.dirname(fname.relative_path_from(@dotfiles_root))
  File.readlines(fname).each do |line|
    uri = line.split('#',2).first.strip
    next if uri.empty?
    target_dir = File.join(base, File.basename(uri, ".git"))
    next if Dir.exist?(target_dir) && Dir.exist?(File.join(target_dir, ".git"))
    system "git", "clone", uri, File.join(base, File.basename(uri, ".git"))
  end
end

def process_dir dir
  #puts "process_dir: #{dir}"
  dir.each_child do |src|
    next if IGNORES.any?{ |re| src.to_s[re] }

    if File.basename(src) == ".git.dot"
      process_git_dot src
      next
    end

    target = src.relative_path_from(@dotfiles_root)
    if src.directory?
      FileUtils.mkdir_p target unless Dir.exist?(target)
      process_dir src
    elsif target.exist?
      # exists and NOT a dir
      old_data = target.read
      new_data = src.read
      next if old_data == new_data

      puts "[?] #{target} already exists, and is different!".yellow
      puts
      show_diff target, src
      puts
      if ask("[?] replace? (y/N)", [:y, :n], :n ) == :y
        bk = target.sub(/$/,'.bk')
        puts "[.] backing up #{target} to #{bk}"
        target.rename bk
        target.make_symlink src
      end
    elsif target.symlink?
      puts "[?] #{target} is a symlink to #{target.radlink}".yellow if target.readlink != src
    else
      # not exists and not a directory
      puts "[.] symlink #{target} -> #{src}"
      target.make_symlink src.relative_path_from(target.dirname)
    end
  end
end

desc "install"
task :install do
  home = ENV['HOME']
  puts "[.] HOME    : #{home}"
  dir = File.expand_path(File.dirname(__FILE__))
  puts "[.] dotfiles: #{dir}"

  error! "[!] dotfiles are not in HOME" unless dir.start_with?(home)

  @dotfiles_root = Pathname.new(dir).relative_path_from(Pathname.new(home))

  data = File.read(__FILE__)
  Dir.chdir home
  error! "[!] relative path guess FAIL" if data != File.read(File.join(@dotfiles_root.to_s,File.basename(__FILE__)))

  process_dir @dotfiles_root

  system "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
  system "vim +PluginInstall +qall"
end
