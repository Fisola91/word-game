module CaptureHelper
  def capture_lines(&block)
    begin
      $stdout = StringIO.new
      yield
      result = {}
      result[:stdout] = $stdout.string
    ensure
      $stdout = STDOUT
    end
    result.fetch(:stdout).split("\n").map(&:strip)
  end
end
