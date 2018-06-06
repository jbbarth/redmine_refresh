Deface::Override.new :virtual_path  => 'my/page',
                     :original      => '7b02b984dabd756a62959aeea9c05db9d378bf7a',
                     :name          => 'add-refresh-link-to-my-page',
                     :insert_top    => 'div.contextual',
                     :partial       => 'redmine_refresh/refresher'

Deface::Override.new :virtual_path  => 'my/custom_page',
                     :original      => '7b02b984dabd756a62959aeea9c05db9d378bf7a',
                     :name          => 'add-refresh-link-to-my-custom-page',
                     :insert_top    => 'div.contextual',
                     :partial       => 'redmine_refresh/refresher'

# Replace javascript_tag helper with script tag so the content is NOT modified by Deface
Deface::Override.new :virtual_path => 'my/page',
                     :name => 'replace_javascript_tag',
                     :replace => 'erb[loud]:contains("javascript_tag")',
                     :text => <<STANDARD_CODE_WITHOUT_JAVASCRIPT_TAG_HELPER
                     <script>
// Code copied from standard my/page without any change
$(document).ready(function(){
  $('#block-select').val('');
  $('.block-receiver').sortable({
    connectWith: '.block-receiver',
    tolerance: 'pointer',
    handle: '.sort-handle',
    start: function(event, ui){$(this).parent().addClass('dragging');},
    stop: function(event, ui){$(this).parent().removeClass('dragging');},
    update: function(event, ui){
      // trigger the call on the list that receives the block only
      if ($(this).find(ui.item).length > 0) {
        $.ajax({
          url: "<%= escape_javascript url_for(:action => "order_blocks") %>",
          type: 'post',
          data: {
            'group': $(this).attr('id').replace(/^list-/, ''),
            'blocks': $.map($(this).children(), function(el){return $(el).attr('id').replace(/^block-/, '');})
          }
        });
      }
    }
  });
});
                      </script>
                      <% if false %>
STANDARD_CODE_WITHOUT_JAVASCRIPT_TAG_HELPER
