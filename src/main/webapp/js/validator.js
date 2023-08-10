function Validator(options){
    var formElement = document.querySelector(options.form);
    function validate(inputElement, rule){
        var messageElement = inputElement.parentElement.querySelector('.form-message');

        if(inputElement){

            // xử lí blur khỏi input
            inputElement.onblur = function(){
                //value: inputElement.value
                //test function: rule.test

                var errorMessage = rule.test(inputElement.value);
                console.log(inputElement);
                console.log(errorMessage);
                if(errorMessage){                      
                    messageElement.innerText = errorMessage;
                    messageElement.classList.add('text-danger');
                    inputElement.classList.add('border-danger');
                }else{
                    messageElement.innerText = '';
                    messageElement.classList.remove('text-danger');
                    inputElement.classList.remove('border-danger');
                }
            }
        }
    }

    if(formElement){
        options.rules.forEach(function(rule){
            var inputElement = formElement.querySelector(rule.selector);
            validate(inputElement,rule)
        })
    }
}

//rules
// có lỗi thì trả re message lỗi
// không có lỗi thì undefined
Validator.isRequired = function(selector){
    return {
        selector: selector,
        test: function(value){
            return value.trim() ? undefined : 'Vui lòng nhập trường này';
        }
    }
}

Validator.isEmail = function(selector){
    return {
        selector: selector,
        test: function(value){   
            var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            return regex.test(value) ? undefined : 'Trường này phải là email';
        }
    }
}

