RegExp isPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
RegExp isEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
RegExp isPan = RegExp(r'^([A-Z]){5}([0-9]){4}([A-Z])$');
RegExp isUpiId = RegExp(r"^[a-zA-Z0-9.-]{2,256}@[a-zA-Z]{2,64}$");
RegExp isPhone = RegExp(r'^\d+$');
RegExp isAadhar = RegExp(
    r'/(^[0-9]{4}[0-9]{4}[0-9]{4}$)|(^[0-9]{4}\s[0-9]{4}\s[0-9]{4}$)|(^[0-9]{4}-[0-9]{4}-[0-9]{4}$)/');
final RegExp panRegex = RegExp(r'^([A-Z]){5}([0-9]){4}([A-Z]){1}$');
