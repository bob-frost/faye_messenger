ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  unless html_tag =~ /^<label/
    %{<span class="has-error">#{html_tag}<span class="help-block">#{instance.error_message.first}</span></span>}.html_safe
  else
    html_tag
  end
end