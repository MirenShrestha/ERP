using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Resources;


namespace ERP.Resources
{
    public class ResourcesHelper
    {
        private ResXResourceReader _readerEn;
        private ResXResourceReader _readerNe;
        private string _path = @"D:\Project Management\DryIce\Projects\ERP\ERP\ERP.Resources\Resource.resx";
        private string _pathNe = @"D:\Project Management\DryIce\Projects\ERP\ERP\ERP.Resources\Resource.ne.resx";
        private Hashtable _resourceEn;
        private Hashtable _resourceNe;
        public ResourcesHelper()
        {
        }
        [Key]
        public int Id { get; set; }
        [Required]
        public string Key { get; set; }
        [Required]
        public string English { get; set; }
        [Required]
        public string Nepali { get; set; }
        public dynamic Data { get; set; }

        public string AddResources(List<ResourcesHelper> data)
        {
            string msg = "";
            try
            {
                //read existing resource
                ReadResource();
                //Modify resources here...
                foreach (var item in data)
                {
                    if (!_resourceEn.ContainsKey(item.Key))
                    {

                        _resourceEn.Add(item.Key, item.English);
                        _resourceNe.Add(item.Key, item.Nepali);
                    }
                }
                //update resource file
                UpdateResourceFile();
                msg = "Inserted";
            }
            catch (Exception ex)
            {
                msg = "ExceptionError";
            }
            return msg;
        }
        public string UpdateResources(ResourcesHelper item)
        {
            string msg = "";
            try
            {
                //read existing resource
                ReadResource();
                //Modify resources here...
                if (_resourceEn.ContainsKey(item.Key))
                {
                    _resourceEn.Remove(item.Key);
                    _resourceNe.Remove(item.Key);
                    _resourceEn.Add(item.Key, item.English);
                    _resourceNe.Add(item.Key, item.Nepali);
                }

                //update resource file
                UpdateResourceFile();
                msg = "Updated";
            }
            catch (Exception ex)
            {
                msg = "ExceptionError";
            }
            return msg;
        }
        public string DeleteResources(ResourcesHelper item)
        {
            string msg = "";
            try
            {
                //read existing resource
                ReadResource();
                //Modify resources here...
                if (_resourceEn.ContainsKey(item.Key))
                {
                    _resourceEn.Remove(item.Key);
                    _resourceNe.Remove(item.Key);
                }
                //update resource file
                UpdateResourceFile();
                msg = "SuccessfullyDeleted";
            }
            catch (Exception ex)
            {
                msg = "ExceptionError";
            }
            return msg;
        }
        /// <summary>
        /// read existing resource files
        /// </summary>
        private void ReadResource()
        {
            if (Directory.Exists(_path))
            {
                return;
            }
            _readerEn = new ResXResourceReader(_path);
            _readerNe = new ResXResourceReader(_pathNe);
            _resourceEn = new Hashtable();
            _resourceNe = new Hashtable();
            if (_readerEn != null)
            {
                foreach (DictionaryEntry d in _readerEn)
                {
                    _resourceEn.Add(d.Key.ToString(), d.Value.ToString());
                }
                _readerEn.Close();
            }
            if (_readerNe != null)
            {
                foreach (DictionaryEntry d in _readerNe)
                {
                    _resourceNe.Add(d.Key.ToString(), d.Value.ToString());
                }
                _readerNe.Close();
            }
        }
        /// <summary>
        /// write to the resource file
        /// </summary>
        /// <param name="resourceEn"></param>
        /// <param name="resourceNe"></param>
        private void UpdateResourceFile()
        {
            ResXResourceWriter writerEn = new ResXResourceWriter(_path);
            ResXResourceWriter writerNe = new ResXResourceWriter(_pathNe);
            foreach (DictionaryEntry d in _resourceEn)
            {
                writerEn.AddResource(d.Key.ToString(), d.Value.ToString());
            }
            writerEn.Generate();
            writerEn.Close();
            foreach (DictionaryEntry d in _resourceNe)
            {
                writerNe.AddResource(d.Key.ToString(), d.Value.ToString());
            }
            writerNe.Generate();
            writerNe.Close();
        }

        public List<ResourcesHelper> List()
        {
            List<ResourcesHelper> lst = new List<ResourcesHelper>();
            if (Directory.Exists(_path))
            {
                return null;
            }
            _readerEn = new ResXResourceReader(_path);

            _resourceEn = new Hashtable();

            if (_readerEn != null)
            {
                foreach (DictionaryEntry d in _readerEn)
                {
                    ResourcesHelper res = new ResourcesHelper();
                    res.Key = d.Key.ToString();
                    res.English = d.Value.ToString();
                    res.Nepali = GetNepaliValue(res.Key);
                    lst.Add(res);
                }
                _readerEn.Close();
            }

            return lst;
        }
        public List<ResourcesHelper> SearchList(string searchKey, string searchBy)
        {
            List<ResourcesHelper> lst = new List<ResourcesHelper>();
            if (Directory.Exists(_path))
            {
                return null;
            }
            //       _readerEn = new ResXResourceReader(@"E:\Project\NCOC\Maple.Resources\Resource.resx");

            //    _resourceEn = new Hashtable();
            ReadResource();
            List<DictionaryEntry> lst1 = _resourceEn.OfType<DictionaryEntry>().Where(x => x.Key.ToString().ToLower().Contains(searchKey.ToLower())).OrderBy(x => x.Key).ToList();
            List<DictionaryEntry> lst2 = _resourceNe.OfType<DictionaryEntry>().Where(x => x.Key.ToString().ToLower().Contains(searchKey.ToLower())).OrderBy(x => x.Key).ToList();
            List<ResourcesHelper> res = new List<ResourcesHelper>();
            ResourcesHelper helper;
            // int i = 0;
            foreach (var item in lst1)
            {
                helper = new ResourcesHelper();
                helper.English = item.Value.ToString();
                helper.Key = item.Key.ToString();
                res.Add(helper);

            }
            foreach (var item in lst2)
            {
                var resource = res.Find(x => x.Key.ToLower() == item.Key.ToString().ToLower());
                if (resource == null)
                {
                    helper = new ResourcesHelper();
                    helper.Key = item.Key.ToString();
                    helper.Nepali = item.Value.ToString();
                    res.Add(helper);
                }
                else
                {
                    res.Find(x => x.Key.ToLower() == item.Key.ToString().ToLower()).Nepali = item.Value.ToString();
                }

            }
            //if (_readerEn != null)
            //{
            //    foreach (DictionaryEntry d in _readerEn)
            //    {

            //        string key = d.Key.ToString();
            //        string english = d.Value.ToString();
            //        string nepali = GetNepaliValue(key);
            //        switch (searchBy)
            //        {
            //            case ("Key"):
            //                if (key == searchKey)
            //                {
            //                    res.Key = key;
            //                    res.English = english;
            //                    res.Nepali = nepali;
            //                    lst.Add(res);
            //                }
            //                break;
            //            case ("English"):
            //                if (english == searchKey)
            //                {
            //                    res.Key = key;
            //                    res.English = english;
            //                    res.Nepali = nepali;
            //                    lst.Add(res);
            //                }
            //                break;
            //            default:
            //                lst = null;
            //                break;
            //        }
            //    }
            //    _readerEn.Close();
            //}

            return res;
        }

        public string GetNepaliValue(string key)
        {
            _readerNe = new ResXResourceReader(_pathNe);
            _resourceNe = new Hashtable();
            string NepaliValue = "";
            if (_readerNe != null)
            {
                foreach (DictionaryEntry d in _readerNe)
                {
                    string neKey = d.Key.ToString();
                    if (neKey == key)
                    {
                        NepaliValue = d.Value.ToString();
                        return NepaliValue;
                    }
                }
                _readerNe.Close();
            }
            return NepaliValue;
        }

        public ResourcesHelper Find(string id)
        {
            ResourcesHelper res = new ResourcesHelper();
            if (Directory.Exists(_path))
            {
                return null;
            }
            _readerEn = new ResXResourceReader(_path);

            _resourceEn = new Hashtable();

            if (_readerEn != null)
            {
                foreach (DictionaryEntry d in _readerEn)
                {
                    string key = d.Key.ToString();
                    if (key == id)
                    {
                        res.Key = d.Key.ToString();
                        res.English = d.Value.ToString();
                        res.Nepali = GetNepaliValue(res.Key);
                    }
                }
                _readerEn.Close();
            }
            return res;

        }

    }
    public class ResourcesHelperViewModel
    {
        public List<ResourcesHelper> ResourcesHelpers { get; set; }
    }

}
