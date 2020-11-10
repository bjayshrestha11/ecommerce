using System.Security.Claims;
using System.Linq;

namespace API.Extensions
{
    public static class ClaimsPrincipalExtensions
    {
       public static string RetrieveEmailFromPrincipal(this ClaimsPrincipal user)
       {
           return user?.Claims?.FirstOrDefault(x => x.Type == ClaimTypes.Email)?.Value;
       } 
    }
}