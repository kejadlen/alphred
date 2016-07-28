require 'tmpdir'

require 'rake'

namespace :alphred do
  desc 'Prepare a release, named after the directory'
  task :release, [:version] => [:tag, :package]

  desc 'Tag the current commit in git with VERSION'
  task :tag, [:version] do |t, args|
    version = args.fetch(:version)

    git_status = `git status --porcelain`
    fail <<-FAIL unless git_status.empty?
Can't tag #{version}: dirty working directory.
    FAIL

    sh "git tag #{version}"
    sh 'git push --tags'
  end

  desc 'Create an alfredworkflow package with vendored dependencies'
  task :package do
    restore_bundler_config do
      vendor_deps

      Dir.mktmpdir do |tmp_dir|
        cp_r FileList[File.join(workflow_dir, ?*)], tmp_dir, verbose: false

        clean_vars(tmp_dir)
        zip_workflow(tmp_dir)
      end

      rm_r 'vendor'
    end
  end

  def restore_bundler_config
    path = File.join(workflow_dir, '.bundle', 'config')
    config = File.read(path)
    yield
  ensure
    File.write(path, config, mode: ?w)
  end

  def vendor_deps
    args = %w[ --standalone
                   --path vendor/bundle
                   --without development test ]
    cmd = "bundle install #{args.join(' ')}"
    sh "chruby-exec 2.0.0 -- #{cmd}"
  end

  def clean_vars(dir)
    info_plist = File.join(dir, 'info.plist')

    vars = `/usr/libexec/PlistBuddy -c "Print :variablesdontexport" #{info_plist}`
    vars = vars.split("\n")[1..-2].map(&:strip)

    vars.each do |var|
      sh "/usr/libexec/PlistBuddy -c \"Set :variables:#{var} ''\" #{info_plist}"
    end
  end

  def zip_workflow(dir)
    cd dir do
      output = File.join(workflow_dir,
                         workflow_name.pathmap('%n.alfredworkflow'))
      sh "zip -rq #{output} *"
    end
  end

  def workflow_name
    workflow_dir.pathmap('%f')
  end

  def workflow_dir
    Rake.application.original_dir
  end
end
