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
    function PleaseHold() {
        $("#pleaseWait").show();
    }

    var ajax = function (location) {

        var odt = {'odt': { lat: location.latitude, lng: location.longitude } };

        return $.ajax({
            url: '/main/getGeolocatedCampaigns',
            contentType: 'application/json',
            dataType: 'json',
            cache: false,
            type: 'post',
            data: JSON.stringify(odt),
            beforeSend: function(){
                $('#loadingCampaigns').show()
            },
            complete: function(){
                $('#loadingCampaigns').hide();
            }
        });
    };

    $(function(){
            if(navigator.geolocation) {
                navigator.geolocation.watchPosition(function(position){
                    var ajaxCall = ajax(position.coords).success(function(data){
                        $('#noCampaigns').hide();

                        if(data.length > 0) {
                            var targetSelector = $('#nearCampaigns');
                            var temp = '';
                           $(data).each(function(index, element){
                               temp += "<div class='col-lg-3 col-md-3'><h2>"+ element.name +"</h2><p>"+element.description+"</p><p><a href='/campaigns/"+element.id+"' class='btn btn-info' role='button'>See More</a></p></div>";
                           });
                           targetSelector.html(temp);
                        } else {
                            $('#noCampaigns').show('slow');
                        }
                    });
                });
            }
            $('.new_campaign').nestedFields({
                itemTemplateSelector: '.template',
                skipBefore: true,
                containerSelector: '#items'
            });

            $window = $(window);
   $('section[data-type="background"]').each(function(){
     // declare the variable to affect the defined data-type
     var $scroll = $(this);
      $(window).scroll(function() {
          var yPos = -($window.scrollTop() / $scroll.data('speed'));
          var coords = '50% '+ yPos + 'px';
        $scroll.css({ backgroundPosition: coords });
      }); // end window scroll
   });  // end section function



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

                $.ajax({
                    url: controller,
                    type: 'get',
                    //data: {money: { amount: amount}},
                    cache: false,
                    beforeSend: function() {
                        $("#pleaseWait").show();
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
