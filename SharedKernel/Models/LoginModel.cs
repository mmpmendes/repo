﻿namespace SharedKernel.Models;
public class LoginModel
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string TwoFactorCode { get; set; } = string.Empty;
    public string TwoFactorRecoveryCode { get; set; } = string.Empty;
}
