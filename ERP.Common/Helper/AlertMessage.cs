
namespace ERP.Common.Helper
{
    public enum MessageType
    {
        Success,
        Error,
        Warning,
        Info,
    }
    public class AlertMessage
    {
        private readonly string _message;
        private readonly bool _alertType;
        private readonly MessageType _messageType;
        private readonly bool _flash;
        private readonly int _seconds;
        private readonly int _timeout;
        private readonly object _data;
        public AlertMessage()
        {

        }
        public AlertMessage(string message, bool alertType, MessageType messageType, bool flash, int seconds, object data,int timeout)
        {
            LocalizedString loc = new LocalizedString();
            _message = loc.Localize(message);
            _alertType = alertType;
            _messageType = messageType;
            _flash = flash;
            _seconds = seconds;
            _data = data;
            _timeout = timeout;

        }
        public string Message { get { return _message; } }
        //1 for alert message and 0 for normal message
        public bool AlertType { get { return _alertType; } }
        public MessageType MessageType { get { return _messageType; } }
        public bool Flash { get { return _flash; } }
        public int Seconds { get { return _seconds; } }
        public object Data { get { return _data; } }

        public static AlertMessage SetMessage(string message, bool alertType, MessageType messageType, bool flash, int seconds, object data)
        {
            AlertMessage msg = new AlertMessage();
            return msg;
        }
    }
}
