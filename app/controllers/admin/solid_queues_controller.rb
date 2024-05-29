# frozen_string_literal: true

module Admin
  # Dashboard for Solid Queue Jobs.
  class SolidQueuesController < Admin::AdminController
    def index
      @jobs = SolidQueue::Job.all
      @blocked_executions = SolidQueue::BlockedExecution.all
      @claimed_executions = SolidQueue::ClaimedExecution.all
      @failed_executions = SolidQueue::FailedExecution.all
      @pauses = SolidQueue::Pause.all
      @processes = SolidQueue::Process.all
      @ready_executions = SolidQueue::ReadyExecution.all
      @scheduled_executions = SolidQueue::ScheduledExecution.all
      @semaphores = SolidQueue::Semaphore.all
    end
  end
end
