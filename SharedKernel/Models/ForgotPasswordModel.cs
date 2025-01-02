﻿using System.ComponentModel.DataAnnotations;

namespace SharedKernel.Models;
public class ForgotPasswordModel
{
    [Required]
    [EmailAddress]
    public string Email { get; set; } = string.Empty;
}
