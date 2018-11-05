json.extract! history, :id, :user_name, :study_date, :section, :score, :num_questions, :created_at, :updated_at
json.url history_url(history, format: :json)
