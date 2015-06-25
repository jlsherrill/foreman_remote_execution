class AddInvocation< ActiveRecord::Migration
  def change
    create_table :targetings do |t|
      t.string :search_query
      t.references :bookmark
      t.references :user
      t.timestamps
    end

    add_foreign_key :targetings, :bookmarks, :name => "targetings_bookmark_id", :column => 'bookmark_id'
    add_foreign_key :targetings, :user, :name => "targetings_user_id", :column => 'user_id'

    create_table :targeting_hosts do |t|
      t.references :host
      t.references :targeting
    end

    add_foreign_key :targeting_hosts, :hosts, :name => "targeting_hosts_host_id", :column => 'host_id'
    add_foreign_key :targeting_hosts, :targeting, :name => "targeting_hosts_targeting_id", :column => 'targeting_id'

    create_table :template_invocations do |t|
      t.references :templates, :null => false
      t.references :targeting, :null => false
    end

    add_foreign_key :template_invocations, :templates, :name => "template_invoc_template_id", :column => 'template_id'
    add_foreign_key :template_invocations, :targeting, :name => "template_invoc_targeting_id", :column => 'targeting_id'

    create_table :template_invocation_input_values do |t|
      t.references :template_invocation, :null => false
      t.references :template_input, :null => false
      t.string :value, :null => false
    end

    add_foreign_key :template_invocation_input_values, :template_invocations, :name => "template_invoc_input_values_template_invoc_id", :column => 'template_invocation_id'
    add_foreign_key :template_invocation_input_values, :template_inputs, :name => "template_invoc_input_values_template_input_id", :column => 'template_input_id'

    create_table :job_invocations do |t|
      t.references :targeting, :null => false
    end

    add_foreign_key :job_invocations, :targetings, :name => "job_invocation_targeting_id", :column => 'targeting_id'
  end
end
