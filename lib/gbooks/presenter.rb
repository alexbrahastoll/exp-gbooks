require 'json'

module Gbooks
  class Presenter
    attr_reader :out

    def initialize(out)
      @out = out
    end

    def print_volumes(volumes)
      if volumes.nil?
        out.write('No results were found.')
        return
      end

      volumes_list =
        volumes.map.with_index do |volume, i|
          "#{i + 1}: #{volume['volumeInfo']['title']}"
        end.join("\n")
      out.write(volumes_list)
    end
  end
end
