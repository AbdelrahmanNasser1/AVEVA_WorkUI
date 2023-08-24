

function DateTimeUtility()
{
    var self = this;

    self.InvariantShortDateFormat = "MM/dd/yyyy";
    self.InvariantLongTimeFormat = "HH:mm:ss";

    self.LocaleShortDateFormat = self.InvariantShortDateFormat;
    self.LocaleLongTimeFormat = self.InvariantLongTimeFormat;

    self.getDisplayTextFromInvariantStringValue = function (_dateTimeInvariantStringValue, hasDatePart, hasTimePart)
    {
        try
        {
            if (areInvariantAndLocaleFormatSame(hasDatePart, hasTimePart))
            {
                return _dateTimeInvariantStringValue;
            }

            var dateTimeValue = self.getDateTimeFromInvariantString(_dateTimeInvariantStringValue, hasDatePart, hasTimePart);
            return self.getLocaleStringFromDateTime(dateTimeValue, hasDatePart, hasTimePart);
        }
        catch (e)
        {
            return "";
        }
    };

    function getDateTimeFormat(hasDatePart, hasTimePart, dateFormat, timeFormat)
    {
        if (isUndefined(hasDatePart))
        {
            hasDatePart = false;
        }
        if (isUndefined(hasTimePart))
        {
            hasTimePart = false;
        }

        if (!hasDatePart && !hasTimePart)
        {
            hasDatePart = true;
            hasTimePart = true;
        }

        return ((hasDatePart ? dateFormat : "") + ((hasDatePart && hasTimePart) ? " " : "") + (hasTimePart ? timeFormat : ""));
    }

    function getInvariantDateTimeFormat(hasDatePart, hasTimePart)
    {
        return getDateTimeFormat(hasDatePart, hasTimePart, self.InvariantShortDateFormat, self.InvariantLongTimeFormat);
        //return ((hasDatePart ? self.InvariantShortDateFormat + " " : "") + (hasTimePart ? self.InvariantLongTimeFormat : ""));
    }

    function getLocaleDateTimeFormat(hasDatePart, hasTimePart)
    {
        return getDateTimeFormat(hasDatePart, hasTimePart, self.LocaleShortDateFormat, self.LocaleLongTimeFormat);
    }

    function getLocaleDateTimeFormatArray(hasDatePart, hasTimePart)
    {
        return [getLocaleDateTimeFormat(hasDatePart, hasTimePart)];
    }

    function getInvariantDateTimeFormatArray(hasDatePart, hasTimePart)
    {
        return [getInvariantDateTimeFormat(hasDatePart, hasTimePart)];
    }

    function areInvariantAndLocaleFormatSame(hasDatePart, hasTimePart)
    {
        return (getInvariantDateTimeFormat(hasDatePart, hasTimePart) === getLocaleDateTimeFormat(hasDatePart, hasTimePart));
    }

    function getStringFromDateTime(_value, format, locale)
    {
        try
        {
            var retVal = kendo.toString(_value, format, locale);
            if (isUndefined(retVal))
            {
                return "";
            }
            return retVal;
        }
        catch (e)
        {
            return "";
        }
    }

    function getDateTimeFromString(_value, formatArray, culture)
    {
        try
        {
            var retVal = kendo.parseDate(_value, formatArray, "en-US");

            if (isUndefined(retVal))
            {
                return null;
            }

            return retVal;
        }
        catch (e)
        {
            return null;
        }
    }

    self.getLocaleStringFromDateTime = function (_value, hasDatePart, hasTimePart)
    {
        return getStringFromDateTime(_value, getLocaleDateTimeFormat(hasDatePart, hasTimePart));
    };

    self.getInvariantStringFromDateTime = function (_value, hasDatePart, hasTimePart)
    {
        return getStringFromDateTime(_value, getInvariantDateTimeFormat(hasDatePart, hasTimePart), "en-US");
    };

    self.getDateTimeFromInvariantString = function (_value, hasDatePart, hasTimePart)
    {
        return getDateTimeFromString(_value, getInvariantDateTimeFormatArray(hasDatePart, hasTimePart));
    };

    self.getDateTimeFromLocaleString = function (_value, hasDatePart, hasTimePart)
    {
        return getDateTimeFromString(_value, getLocaleDateTimeFormatArray(hasDatePart, hasTimePart));
    };
}

function NumberUtility()
{
    var self = this;
    self.DecimalDisplayFormat = "#,.#########";
    self.DecimalStorageFormat = "#.#########";
    self.IntegerDisplayFormat = "n0";
    self.IntegerStorageFormat = "#";

    self.getNumberDisplayText = function (_value, _hasDecimal)
    {
        try
        {
            var numValue = self.getNumberFromInvariantString(_value);
            return self.getLocaleStringFromNumber(numValue, _hasDecimal);
        }
        catch (e)
        {
            return "";
        }
    };

    self.getLocaleStringFromNumber = function (_value, _hasDecimal)
    {
        try
        {
            var retVal = kendo.toString(_value, (_hasDecimal ? self.DecimalDisplayFormat : self.IntegerDisplayFormat));
            if (isUndefined(retVal))
            {
                return "";
            }
            return retVal;
        }
        catch (e)
        {
            return "";
        }
    };

    self.getInvariantStringFromNumber = function (_value, _hasDecimal)
    {
        try
        {
            var retVal = kendo.toString(_value, (_hasDecimal ? self.DecimalStorageFormat : self.IntegerStorageFormat), "en-US");
            if (isUndefined(retVal))
            {
                return "";
            }
            return retVal;
        }
        catch (e)
        {
            return "";
        }
    };

    self.getNumberFromInvariantString = function (_value)
    {
        try
        {
            return kendo.parseFloat(_value, "en-US");
        }
        catch (e)
        {
            return null;
        }
    };

    self.getNumberFromLocaleString = function (_value)
    {
        try
        {
            return kendo.parseFloat(_value);
        }
        catch (e)
        {
            return null;
        }
    };
}