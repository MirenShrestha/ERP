using System;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;


namespace ERP.Common.Localization
{
    
    public class LocalizedModelMetadataProvider : DataAnnotationsModelMetadataProvider
    {
        protected override ModelMetadata CreateMetadata(IEnumerable<Attribute> attributes, Type containerType, Func<object> modelAccessor, Type modelType, string propertyName)
        {
            CultureInfo culture = CultureInfo.CurrentCulture;
            var metadata = base.CreateMetadata(attributes, containerType, modelAccessor, modelType, propertyName);

            if (containerType == null || propertyName == null)
                return metadata;

            if (metadata.DisplayName == null)
                metadata.DisplayName = null;// Resources.Resource.ResourceManager.GetString(propertyName, culture);
            return metadata;
        }
    }

    public class LocalizedModelValidatorProvider : DataAnnotationsModelValidatorProvider
    {
        protected override IEnumerable<ModelValidator> GetValidators(ModelMetadata metadata, ControllerContext context, IEnumerable<Attribute> attributes)
        {
            CultureInfo culture = CultureInfo.CurrentCulture;
            foreach (var attribute in attributes.OfType<ValidationAttribute>())
                if (attribute.TypeId.ToString() == "System.ComponentModel.DataAnnotations.RequiredAttribute")
                {
                    attribute.ErrorMessage = null;// Resources.Resource.ResourceManager.GetString("Required", culture);
                }
            return base.GetValidators(metadata, context, attributes);
        }
    }



}
