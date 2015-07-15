object @job_invocation

extends "api/v2/job_invocations/main"

node :targeting do
  attributes :bookmark_id, :search_query, :targeting_type, :user_id
end

node :template_invocations do
  attributes :template_id
  child :input_values do
    attributes :input_id, :value
  end
end
