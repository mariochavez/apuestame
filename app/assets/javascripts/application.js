// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.nested-fields
//= require_tree .

(function(init) {
    init(window.jQuery, window, document);
}(function($, window, document){
    $(function(){
            $('.new_campaign').nestedFields({
                itemTemplateSelector: '.template',
                skipBefore: true,
                containerSelector: '#items'
            });

            $(document).on('click', 'button[data-action=donate], a[data-action=donate]', function(e){
                var self = $(this),
                    modal = $(self.data('modal')),
                    controller = self.data('controller'),
                    panel = $(self.data('updatepanel'));

                $.ajax({
                    url: controller,
                    type: 'get',
                    cache: false,
                    beforeSend: function() {
                    },
                    complete: function() {
                    },
                    success: function(data) {
                        panel.html(data);
                        modal.modal('show');
                    },
                    error: function(jqXHR, error, status) {
                        console.log(jqXHR);
                    }
                });
            }).on('click', 'button[data-action=complete-donation], a[data-action=complete-donation]', function(e) {
                var self = $(this),
                    modal = $(self.data('modal')),
                    controller = self.data('controller');
                    amount = $('#txtAmount').val();

                $.ajax({
                    url: controller,
                    type: 'get',
                    data: {money: { amount: amount}},
                    cache: false,
                    beforeSend: function() {
                    },
                    complete: function() {
                    },
                    success: function(data) {
                        if(data) {
                            var links = data.links;
                            var payment_id = data.payment_id;
                            window.location.href = links[1].href;
                        }
                        console.log(data);
                    },
                    error: function(jqXHR, error, status) {
                        console.log(jqXHR);
                    }
                });
            });
    });
}));
