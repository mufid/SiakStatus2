# Start worker if not in IRB mode
# SiakWorker.new.start unless defined?(IRB)

if not defined?(IRB)
  Rails.logger.info "[WORKER] Retrieving data"
  scheduler = Rufus::Scheduler.start_new

  scheduler.every '2s', SiakWorker, blocking: false, allow_overlapping: false
end