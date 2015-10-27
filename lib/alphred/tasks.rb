require "rake"

namespace :alphred do
  desc "Prepare a release, named after the directory"
  task :release, [:version] => [:vendor_check, :tag, :package]

  task :tag, [:version] do |t, args|
    version = args[:version]

    git_status = `git status --porcelain`
    fail <<-FAIL unless git_status.empty?
Can't tag #{version}: dirty working directory.
    FAIL

    sh "git tag #{version}"
    sh "git push origin #{version}"
  end

  task :package do
    sh "zip -r #{__FILE__.pathmap("%-1d").pathmap("%n.alfredworkflow")} *"
    rm_rf "vendor"
    sh "bundle install --no-deployment"
  end

  # Unfortunately, this can't be done automatically due to this chruby issue:
  #   https://github.com/postmodern/chruby/issues/193
  task :vendor_check do
    puts <<-PUTS
Did you remember to vendor your dependencies?

  rm -rf vendor
  rake workflow:vendor[2.0.0]

Continue? (y/[n])
    PUTS
    abort if STDIN.gets.chomp.downcase != ?y
  end

  desc "Vendor Ruby gem dependencies"
  task :vendor, [:version] do |_, args|
    version = args[:version]
    sh "chruby-exec #{version} -- bundle install --deployment --standalone"
  end
end