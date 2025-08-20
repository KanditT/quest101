# frozen_string_literal: true

class QuestsController < ApplicationController
  before_action :set_quest, only: %i[show edit update destroy toggle_status]

  def index
    @quests = Quest.order(created_at: :desc)
    @quest = Quest.new
  end

  def show; end

  def new
    @quest = Quest.new
  end

  def edit; end

  def create # rubocop:disable Metrics/MethodLength
    @quest = Quest.new(quest_params)
    @quest.status = false

    respond_to do |format|
      if @quest.save
        format.turbo_stream
        format.html { redirect_to quests_path }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('quest_form', partial: 'form', locals: { quest: @quest })
        end
        format.html { render :index }
      end
    end
  end

  def update
    respond_to do |format|
      if @quest.update(quest_params)
        format.turbo_stream
        format.html { redirect_to @quest }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @quest&.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to quests_path }
    end
  end

  def toggle_status
    @quest.update(status: !@quest.status)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to quests_path }
    end
  end

  private

  def set_quest
    @quest = Quest.find_by(id: params[:id])
  end

  def quest_params
    params.expect(quest: %i[name status])
  end
end
