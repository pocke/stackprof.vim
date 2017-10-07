require 'json'
require 'open3'

module StackprofVim
  CommandExecuteError = Class.new(StandardError)
  class << self
    def stackprof(file: 'stackprof-out', method: nil)
      cmd = ['stackprof', file]
      cmd.concat(['-m', method]) if method
      out, = sh!({'RUBYOPT' => ''}, *cmd)
      Vim.command 'tabnew'
      Vim.set_option 'buftype=nofile'
      Vim.set_option 'filetype=stackprof'
      Vim.evaluate "append(0, #{out.split("\n").to_json})"
    end

    def line_to_method
      line = Vim.evaluate 'getline(".")'
      line[/([^ ]+)$/, 1]
    end

    private

    def sh!(*cmd)
      Open3.capture3(*cmd).tap do |out, err, status|
        raise CommandExecuteError.new("stdout:\n#{out}\nstderr:\n#{err}") unless status.success?
      end
    end
  end
end
