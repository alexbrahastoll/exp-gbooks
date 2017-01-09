require 'json'

module Gbooks
  class Presenter
    attr_reader :out

    def initialize(out)
      @out = out
    end

    def puts(text)
      out.puts(text)
    end

    def print_volumes(volumes)
      if volumes.nil?
        puts('No results were found.')
        return
      end

      volumes_list =
        volumes.map.with_index do |volume, i|
          "#{i + 1}: #{volume['volumeInfo']['title']}"
        end.join("\n")
      puts(volumes_list)
    end
  end
end
