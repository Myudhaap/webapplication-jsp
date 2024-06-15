$(document).ready(function (){
    $("#loginForm").submit(function(e){
        e.preventDefault()

        console.log("asd")

        let isValid = true

        $(".error").remove()

        const userId = $("#userId").val()
        const password = $("#password").val()

        if(userId === ""){
            isValid = false
            $("#userId").after("<span class='error text-danger'>UserId required.</span>")
        }

        if(password === ""){
            isValid = false
            $("#password").after("<span class='error text-danger'>Password required.</span>")
        }

        if(isValid){
            $.ajax({
                url: "loginServlet",
                method: "POST",
                data: {
                    userId: userId,
                    password: password
                },
                success: function(res){
                    if(res.success){
                        window.location.href = "../index.jsp"
                    }else{
                        $("#loginForm").prepend("<div class='error alert alert-danger'>" + res.message + "</div>")
                    }
                },
                error: function (err){
                    console.log(err)
                }
            })
        }
    })
})