namespace :core do
  task :load_core_seeds do
    Core::Engine.load_seed 
  end
end
