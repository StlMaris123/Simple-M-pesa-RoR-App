module Api
  module V1
    class ReportsController < ApplicationController
      def generate_report
        TransactionReportJob.perform_later(user: Current.user, transaction_ids: user_transactions.ids)

        render json: { message: 'Report has been sent to your email.' }, status: :ok
      end

      private

      def start_date = params.fetch(:start_date, Time.current).beginning_of_day
      def end_date   = params.fetch(:end_date, Time.current).end_of_day

      def user_transactions
        return AccountTransaction.none if user.transactions.empty?

        user.transactions.for_date_range(start_date, end_date)
      end
    end
  end
end
