namespace FileService.Models;

public class S3ObjectDto
{
    public string? Name { get; set; }
    public string? PreSignedUrl { get; set; }
}