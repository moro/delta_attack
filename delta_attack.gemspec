Gem::Specification.new do |s|
  s.name = %q{delta_attack}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["MOROHASHI Kyosuke"]
  s.date = %q{2008-09-30}
  s.default_executable = %q{delta_attack_server}
  s.description = %q{extract text from MS Office document with Apache POI}
  s.email = %q{moronatural@gmail.com}
  s.executables = ["delta_attack_server"]
  s.extra_rdoc_files = ["README", "ChangeLog"]
  s.files = ["README", "NOTICE", "ChangeLog", "Rakefile", "bin/delta_attack_server", "spec/extractor", "spec/extractor/excel_spec.rb", "spec/extractor/power_point_spec.rb", "spec/extractor/servlet_spec.rb", "spec/extractor/word_spec.rb", "spec/extractor_spec.rb", "spec/filetype_assumption_spec.rb", "spec/spec_helper.rb", "lib/delta_attack", "lib/delta_attack/client.rb", "lib/delta_attack/extractor", "lib/delta_attack/extractor/base.rb", "lib/delta_attack/extractor/excel.rb", "lib/delta_attack/extractor/power_point.rb", "lib/delta_attack/extractor/servlet.rb", "lib/delta_attack/extractor/word.rb", "lib/delta_attack/extractor.rb", "lib/delta_attack/filetype_assumption.rb", "lib/delta_attack.rb", "lib/vendor", "lib/vendor/README"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/moro/delta_attack}
  s.rdoc_options = ["--title", "delta_attack documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{extract text from MS Office document with Apache POI}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
