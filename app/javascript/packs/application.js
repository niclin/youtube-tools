// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery"
import DonateGoalChannel from "../channels/donate_goal_channel";
import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'
require("stylesheets/application.scss")
import Vue from 'vue/dist/vue.esm'
import Lottery from "../components/Lottery"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '[data-behavior="vue-app"]',
    components: { Lottery }
  })
})

$(document).on('turbolinks:load', function () {
  $("form#set_name").on('submit', function(e){
    e.preventDefault();
    let name = $('#add_name').val();
    sessionStorage.setItem('chat_room_name', name)
    DonateGoalChannel.announce({ name, type: 'join'})
    $("#modal").css('display', 'none');
  });

  $("form#send_message").on('submit', function(e){
    e.preventDefault();
    let message = $('#message').val();
    if (message.length > 0) {
      DonateGoalChannel.speak(message);
      $('#message').val('')
    }
  });

  $(window).on('beforeunload', function() {
    let name = sessionStorage.getItem('chat_room_name')
    DonateGoalChannel.announce({ name, type: 'leave'})
  });
})