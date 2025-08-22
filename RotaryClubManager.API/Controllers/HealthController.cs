using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RotaryClubManager.Infrastructure.Data;

namespace RotaryClubManager.API.Controllers
{
    [Route("health")]
    [ApiController]
    public class HealthController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogger<HealthController> _logger;

        public HealthController(ApplicationDbContext context, ILogger<HealthController> logger)
        {
            _context = context;
            _logger = logger;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                // Check database connectivity
                await _context.Database.CanConnectAsync();
                
                var healthCheck = new
                {
                    status = "Healthy",
                    timestamp = DateTime.UtcNow,
                    version = "1.0.0",
                    environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT"),
                    database = "Connected"
                };

                return Ok(healthCheck);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Health check failed");
                
                var healthCheck = new
                {
                    status = "Unhealthy",
                    timestamp = DateTime.UtcNow,
                    version = "1.0.0",
                    environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT"),
                    database = "Disconnected",
                    error = ex.Message
                };

                return StatusCode(503, healthCheck);
            }
        }
    }
}
