
using System.Collections.Generic;

namespace ERP.Service.Interfaces
{
    //The Generic Interface Repository for Performing Read/Add/Delete operations
    public interface IBaseService<TEnt, in TPk,out TResult> where TEnt : class
    {
        IEnumerable<TEnt> List();
        TEnt GetById(TPk id);
        TResult Update(TEnt entity,string flag);
        TResult Delete(TPk id);
        IEnumerable<TEnt> ListActive();

    }

}
