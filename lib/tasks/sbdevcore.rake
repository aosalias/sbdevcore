namespace :sbdevcore do
  desc "load sbdev core seeds"
  task :seed => :environment do
    Sbdevcore::Engine.load_seed
  end
end
