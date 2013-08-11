# Start worker if not in IRB mode
# SiakWorker.new.start unless defined?(IRB)

if not defined?(IRB)
  SiakWorker.new.start
end