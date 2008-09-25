require 'webrick/httpservlet'
require 'delta_attack/extractor'
require 'delta_attack/filetype_assumption'

module DeltaAttack
  module Extractor
    class Servlet < WEBrick::HTTPServlet::AbstractServlet
      def do_GET(req, res)
        res.body = <<-HTML
<html>
  <head></head>
  <body>
    <form action="/extract" enctype="multipart/form-data" method="post">
      <input type="file" name="file" />
      <input type="submit" name="submit" value="up" />
    </form>
  </body>
</html>
        HTML
      end

      def do_POST(req, res)
        f = req.query["file"]
        type = FiletypeAssumption.new(f.filename, f['content-type'])
        begin
          res.body = Extractor.extract(f.to_s, type.filetype)
          res.content_type = "text/plain"
        rescue Extractor::Error => exe
          raise WEBrick::HTTPStatus::BadRequest, exe.message
        rescue StandardError => stdex
          raise WEBrick::HTTPStatus::InternalServerError, stdex.message
        end
      end
    end
  end
end

