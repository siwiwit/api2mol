module RMOF
  module Config
    RMOF_ROOT   = File.join(File.dirname(__FILE__), '..')

    MODELS_ROOT = File.join(RMOF_ROOT, 'rmof', 'models')
    CACHE_DIR   = File.join(RMOF_ROOT, 'rmof', 'cache')

    RMOF_CACHE_DIR = CACHE_DIR # Remove the former
  end
end
