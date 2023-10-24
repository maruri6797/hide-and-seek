// 新規会員登録
$(document).on('turbolinks:load', function () {
  $('#r-form').validate({
    rules: {
      "user[name]":{
        required: true,
        maxlength: 20,
      },
      "user[mbti]":{
        required: true,
      },
      "user[email]":{
        required: true,
        email: true,
      },
      "user[password]":{
        required: true,
      },
      "user[password_confirmation]":{
        required: true,
      },
    },

    messages:{
      "user[name]":{
        required: "ユーザー名を入力して下さい",
        maxlength: "ユーザー名は20文字以下で入力して下さい"
      },
      "user[mbti]":{
        required: "いずれかを選択してください"
      },
      "user[email]":{
        required: "メールアドレスを入力して下さい",
        email: "有効なメールアドレスを入力して下さい"
      },
      "user[password]":{
        required: "パスワードを入力して下さい",
      },
      "user[password_confirmation]":{
        required: "パスワードを入力して下さい"
      },
    },
    errorClass: "invalid",
    validClass: "valid",
  });
  $("#user_name, #user_email, #user_password, #user_password_confirmation").blur(function(){
    $(this).valid();
  });
});

// ログイン
$(document).on('turbolinks:load', function () {
  $('#s-form').validate({
    rules: {
      "user[email]":{
        required: true,
        email: true,
      },
      "user[password]":{
        required: true,
      },
    },

    messages:{
      "user[email]":{
        required: "メールアドレスを入力して下さい",
        email: "有効なメールアドレスを入力して下さい"
      },
      "user[password]":{
        required: "パスワードを入力して下さい"
      },
    },
    errorClass: "invalid",
    validClass: "valid",
  });
  $("#user_email, #user_password").blur(function(){
    $(this).valid();
  });
});

// お問い合わせ
$(document).on('turbolinks:load', function () {
  $('#c-form').validate({
    rules: {
      "contact[name]":{
        required: true,
      },
      "contact[email]":{
        required: true,
        email: true,
      },
      "contact[subject]":{
        required: true,
      },
      "contact[content]":{
        required: true,
      },
    },

    messages:{
      "contact[name]":{
        required: "お名前を入力して下さい"
      },
      "contact[email]":{
        required: "メールアドレスを入力して下さい",
        email: "有効なメールアドレスを入力して下さい"
      },
      "contact[subject]":{
        required: "件名を入力して下さい"
      },
      "contact[content]":{
        required: "内容を入力して下さい"
      },
    },
    errorClass: "invalid",
    validClass: "valid",
  });
  $("#contact_name, #contact_email, #contact_subject, #contact_content").blur(function(){
    $(this).valid();
  });
});

// 投稿
$(document).on('turbolinks:load', function () {
  $('#p-form').validate({
    rules: {
      "post[title]":{
        required: true,
        maxlength: 20,
      },
      "post[text]":{
        required: true,
        maxlength: 500,
      },
    },

    messages:{
      "post[title]":{
        required: "タイトルを入力して下さい",
        maxlength: "タイトルは20文字以下で入力して下さい"
      },
      "post[text]":{
        required: "テキストを入力して下さい",
        maxlength: "テキストは500文字以下で入力して下さい"
      },
    },
    errorClass: "invalid",
    validClass: "valid",
  });
  $("#post_title, #post_text").blur(function(){
    $(this).valid();
  });
});

// ユーザー編集
$(document).on('turbolinks:load', function () {
  $('#u-form').validate({
    rules: {
      "user[name]":{
        required: true,
        maxlength: 20,
      },
      "user[introduction]":{
        maxlength: 200,
      },
    },

    messages:{
      "user[name]":{
        required: "ユーザー名を入力して下さい",
        maxlength: "ユーザー名は20文字以下で入力して下さい"
      },
      "user[introduction]":{
        maxlength: "自己紹介は200文字以下で入力して下さい"
      },
    },
    errorClass: "invalid",
    validClass: "valid",
  });
  $("#user_name, #user_introduction").blur(function(){
    $(this).valid();
  });
});