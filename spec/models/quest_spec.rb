# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quest do
  describe 'validations' do
    it 'is valid with a name' do
      quest = described_class.new(name: 'Learn Ruby on Rails')
      expect(quest).to be_valid
    end

    it 'is invalid without a name' do
      quest = described_class.new(name: nil)
      expect(quest).not_to be_valid
    end

    it 'is invalid with an empty name' do
      quest = described_class.new(name: '')
      expect(quest).not_to be_valid
    end

    it 'is invalid with a blank name' do
      quest = described_class.new(name: '   ')
      expect(quest).not_to be_valid
    end

    it 'adds an error on name' do
      quest = described_class.new(name: nil)
      quest.validate
      expect(quest.errors[:name]).to include("can't be blank")
    end
  end

  describe 'callbacks' do
    describe '#set_default_status' do
      it 'sets status to false when creating a new record' do
        quest = described_class.new(name: 'Test Quest')
        expect(quest.status).to be(false)
      end

      it 'sets status to false when building a new record' do
        quest = described_class.build(name: 'Test Quest')
        expect(quest.status).to be(false)
      end

      it 'does not override status if explicitly set to true' do
        quest = described_class.new(name: 'Test Quest', status: true)
        expect(quest.status).to be(true)
      end

      it 'does not override status if explicitly set to false' do
        quest = described_class.new(name: 'Test Quest', status: false)
        expect(quest.status).to be(false)
      end

      it 'sets status to false when created and saved' do
        quest = described_class.create!(name: 'Test Quest')
        expect(quest.status).to be(false)
      end

      it 'does not change status when loading existing record from database' do
        quest = described_class.create!(name: 'Test Quest', status: true)
        reloaded_quest = described_class.find(quest.id)
        expect(reloaded_quest.status).to be(true)
      end

      it 'only runs callback on new records' do
        quest = described_class.create!(name: 'Test Quest', status: true)
        loaded_quest = described_class.find(quest.id)
        expect(loaded_quest.status).to be(true)
      end
    end
  end

  describe 'default values' do
    it 'sets status to false by default when no status provided' do
      quest = described_class.create!(name: 'Test Quest')
      expect(quest.status).to be(false)
    end

    it 'respects explicitly provided status value of true' do
      quest = described_class.create!(name: 'Test Quest', status: true)
      expect(quest.status).to be(true)
    end

    it 'respects explicitly provided status value of false' do
      quest = described_class.create!(name: 'Test Quest', status: false)
      expect(quest.status).to be(false)
    end
  end

  describe 'status management' do
    let(:quest) { described_class.create!(name: 'Test Quest') }

    it 'can toggle status from false to true' do
      quest.update!(status: true)
      expect(quest.status).to be(true)
    end

    it 'can toggle status from true to false' do
      quest.update!(status: true)
      quest.update!(status: false)
      expect(quest.status).to be(false)
    end

    it 'can toggle status using bang method' do
      original_status = quest.status
      quest.update!(status: !quest.status)
      expect(quest.status).to eq(!original_status)
    end
  end

  describe 'database persistence' do
    it 'persists the default status to database' do
      quest = described_class.create!(name: 'Test Quest')
      quest.reload
      expect(quest.status).to be(false)
    end

    it 'persists explicitly set status to database' do
      quest = described_class.create!(name: 'Test Quest', status: true)
      quest.reload
      expect(quest.status).to be(true)
    end
  end

  describe 'edge cases' do
    it 'does not change status when updating other attributes' do
      quest = described_class.create!(name: 'Test Quest', status: true)
      quest.update!(name: 'Updated Quest')
      expect(quest.status).to be(true)
    end
  end

  describe 'mass assignment' do
    it 'allows status to be set via mass assignment' do
      quest = described_class.new(name: 'Test Quest', status: true)
      expect(quest.status).to be(true)
    end

    it 'uses default when status not provided in mass assignment' do
      quest = described_class.new(name: 'Test Quest')
      expect(quest.status).to be(false)
    end
  end
end
