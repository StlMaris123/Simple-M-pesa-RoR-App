module Api
  module V1
    class ReportsController < ApplicationController
      def generate_report
        TransactionReportJob.perform_later(user_id: user.id, transaction_ids: user_transactions.ids)

        render json: { message: 'Report has been sent to your email.' }, status: :ok
      end

      private

      def start_date
         Date.parse(params.fetch(:start_date, Time.current)).beginning_of_day
      end

      def end_date   
        Date.parse(params.fetch(:end_date, Time.current)).end_of_day
      end

      def user = Current.user

      def user_transactions
        return AccountTransaction.none if user.account_transactions.empty?

        user.account_transactions.for_date_range(start_date, end_date)
      end
    end
  end
end
