require 'rake/clean'

CLEAN.include( 'pnote.vba' )

COMPONENTS = 
    "plugin/pnote.vim" ,
    "ftplugin/pnote.vim",
    "syntax/pnote.vim"

VIMDIR = (ENV['VIMRUNTIME'] || ENV['HOME'] + "/.vim")
abort if not File.directory? VIMDIR

desc "Get PNOTE files from Vim folder"
task :get do
    COMPONENTS.each do |target|
        source = VIMDIR + target
        unless uptodate?(target, source)
            copy source, target
        end
    end
end

desc "Pack all files into a VBA file (release)"
task :vba => :clean do
    abort("ERROR Temporal file already exists!") if File.exist? 'f.tmp' 
    File.open('f.tmp', 'w') do |out|  
      out.puts COMPONENTS
    end  
    sh %{VIM -s build.vim}
    #rm f.tmp
end

