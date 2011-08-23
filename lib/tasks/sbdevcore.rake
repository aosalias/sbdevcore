namespace :sbdevcore do
  desc "load sbdev core seeds"
  task :seed => :environment do
    Sbdevcart::Engine.load_seed
  end
end
