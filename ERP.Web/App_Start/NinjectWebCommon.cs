using System;
using System.Web;
using Microsoft.Web.Infrastructure.DynamicModuleHelper;
using Ninject;
using Ninject.Web.Common;
using Ninject.Web.Common.WebHost;
using ERP.Web.App_Start;
using ERP.Service.Services.UserManagement;
using ERP.Service.Interfaces.UserManagement;
using ERP.Service.Interfaces.GeneralManagement;
using ERP.Service.Services.GeneralManagement;
using ERP.Service.Services.TicketingManagement;
using ERP.Service.Interfaces.TicketingManagement;
using ERP.Service.Interfaces;
using ERP.Service.Services;
using ERP.Service.Services.HRManagement;
using ERP.Service.Interfaces.HRManagement;

[assembly: WebActivatorEx.PreApplicationStartMethod(typeof(NinjectWebCommon), "Start")]
[assembly: WebActivatorEx.ApplicationShutdownMethodAttribute(typeof(NinjectWebCommon), "Stop")]
namespace ERP.Web.App_Start
{
    public static class NinjectWebCommon
    {
        private static readonly Bootstrapper bootstrapper = new Bootstrapper();

        /// <summary>
        /// Starts the application
        /// </summary>
        public static void Start()
        {
            DynamicModuleUtility.RegisterModule(typeof(OnePerRequestHttpModule));
            DynamicModuleUtility.RegisterModule(typeof(NinjectHttpModule));
            bootstrapper.Initialize(CreateKernel);
        }

        /// <summary>
        /// Stops the application.
        /// </summary>
        public static void Stop()
        {
            bootstrapper.ShutDown();
        }

        /// <summary>
        /// Creates the kernel that will manage your application.
        /// </summary>
        /// <returns>The created kernel.</returns>
        private static IKernel CreateKernel()
        {
            var kernel = new StandardKernel();
            try
            {
                kernel.Bind<Func<IKernel>>().ToMethod(ctx => () => new Bootstrapper().Kernel);
                kernel.Bind<IHttpModule>().To<HttpApplicationInitializationHttpModule>();

                RegisterServices(kernel);
                return kernel;
            }
            catch
            {
                kernel.Dispose();
                throw;
            }
        }

        /// <summary>
        /// Load your modules or register your services here!
        /// </summary>
        /// <param name="kernel">The kernel.</param>
        private static void RegisterServices(IKernel kernel)
        {
            kernel.Bind<ICommonLibraryService>().To<CommonLibraryService>();

            #region GeneralManagements
            kernel.Bind<IUserService>().To<UserService>();
            kernel.Bind<IOrganistaionService>().To<OrganisationService>();
            kernel.Bind<IDropDownService>().To<DropDownService>();
            kernel.Bind<IFiscalYearService>().To<FiscalYearService>();
            kernel.Bind<ISettingsService>().To<SettingsService>();
            kernel.Bind<IRoleManagementService>().To<RoleManagementService>();
            kernel.Bind<IDepartmentService>().To<DepartmentService>();
            kernel.Bind<IAgentsService>().To<AgentsService>();
            kernel.Bind<IDesignationService>().To<DesignationService>();
            kernel.Bind<IDeductionsService>().To<DeductionsService>();
            kernel.Bind<IEarningsService>().To<EarningsService>();
            kernel.Bind<IWorkinPointService>().To<WorkinPointService>();
            kernel.Bind<IShiftService>().To<ShiftService>();
            #endregion

            #region UserManagement
            kernel.Bind<IRoleService>().To<RoleService>();
            #endregion

            #region TicketingManagement
            kernel.Bind<ICategoryService>().To<CategoryService>();
            kernel.Bind<IPackageService>().To<PackageService>();
            kernel.Bind<IStationService>().To<StationService>();
            kernel.Bind<ITicketRateService>().To<TicketRateService>();
            kernel.Bind<ICounterSettlementService>().To<CounterSettlementService>();

            kernel.Bind<IReportService>().To<ReportService>();
            #endregion

            #region HRManagement
            kernel.Bind<IEmployeeService>().To<EmployeeService>();
            kernel.Bind<ILeaveService>().To<LeaveService>();

            #endregion
        }

    }
}
