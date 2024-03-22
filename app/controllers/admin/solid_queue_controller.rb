module Admin
  class SolidQueueController < AdminController
    def index
      @jobs = SolidQueue::Job.all
    end

    def blocked_executions
      @blocked_executions = SolidQueue::BlockedExecution.all
    end

    def claimed_executions
      @claimed_executions = SolidQueue::ClaimedExecution.all
    end

    def failed_executions
      @failed_executions = SolidQueue::FailedExecution.all
    end

    def pauses
      @pauses = SolidQueue::Pause.all
    end

    def processes
      @processes = SolidQueue::Process.all
    end

    def ready_executions
      @ready_executions = SolidQueue::ReadyExecution.all
    end

    def scheduled_executions
      @scheduled_executions = SolidQueue::ScheduledExecution.all
    end

    def semaphores
      @semaphores = SolidQueue::Semaphore.all
    end
  end
end
