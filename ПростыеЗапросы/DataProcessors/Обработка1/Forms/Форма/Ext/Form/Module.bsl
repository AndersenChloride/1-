﻿
&НаКлиенте
Процедура Запрос1(Команда)
	Запрос1НаСервере();
КонецПроцедуры

&НаСервере
Процедура Запрос1НаСервере()
	Номер = ЭтаФорма.Порог;
	Запрос1 = Новый Запрос();
	Запрос1.Текст = "ВЫБРАТЬ
	                       |	Товары.Наименование,
	                       |	Товары.Цена
	                       |ИЗ
	                       |	Справочник.Товары КАК Товары
	                       |ГДЕ
	                       |	Товары.Цена > &Порог";
	
	Запрос1.УстановитьПараметр("Порог", Номер);
	РезультатЗапроса = Запрос1.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = "" + Выборка.Наименование + Выборка.Цена;
		Сообщение.Сообщить();
	КонецЦикла
КонецПроцедуры



&НаКлиенте
Процедура Запрос2(Команда)
	Запрос2НаСервере();
КонецПроцедуры

&НаСервере
Процедура Запрос2НаСервере()
Запрос2 = Новый Запрос;
Запрос2.Текст = "ВЫБРАТЬ
	|	Товары.Цена КАК Цена,
	|	КОЛИЧЕСТВО(Товары.Цена) КАК Количество
	|ИЗ
	|	Справочник.Товары КАК Товары
	|СГРУППИРОВАТЬ ПО
	|	Товары.Цена";
	
РезультатЗапроса = Запрос2.Выполнить();
Выборка = РезультатЗапроса.Выбрать();
Пока Выборка.Следующий() Цикл
	Сообщение = Новый СообщениеПользователю();
	Сообщение.Текст = "" + Выборка.Цена + ": " + Выборка.Количество;
	Сообщение.Сообщить();
	
КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура Запрос3(Команда)
	Запрос3НаСервере();
КонецПроцедуры


&НаСервере
Процедура Запрос3НаСервере()
	Запрос3 = Новый Запрос();
	Запрос3.Текст ="ВЫБРАТЬ
	               |	Контрагенты.Наименование
	               |ИЗ
	               |	Справочник.Контрагенты КАК Контрагенты
				   |ГДЕ Контрагенты.ЭтоГруппа = ЛОЖЬ
	               |
	               |ОБЪЕДИНИТЬ
	               |
	               |ВЫБРАТЬ
	               |	ФизическиеЛица.Наименование
	               |ИЗ
	               |	Справочник.ФизическиеЛица КАК ФизическиеЛица";
		
	РезультатЗапроса = Запрос3.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = Выборка.Наименование;
		Сообщение.Сообщить();
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура Запрос4(Команда)
	Запрос4НаСервере();
КонецПроцедуры

&НаСервере
Процедура Запрос4НаСервере()
	Запрос4 = Новый Запрос();
	Запрос4.Текст = "ВЫБРАТЬ
	                |	Товары.Наименование,
	                |	Товары.Цена
	                |ИЗ
	                |	Справочник.Товары КАК Товары
					|ГДЕ Товары.Цена В (ВЫБРАТЬ МАКСИМУМ(Цена) ИЗ Справочник.Товары) "
	              ;
	
	РезультатЗапроса = Запрос4.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = Выборка.Наименование;
		Сообщение.Сообщить();	
	КонецЦикла
КонецПроцедуры

&НаКлиенте
Процедура Запрос5(Команда)
	Запрос5НаСервере();
КонецПроцедуры

&НаСервере
Процедура Запрос5НаСервере()
	
	Запрос5 = Новый Запрос();
	Запрос5.Текст = 	"ВЫБРАТЬ
		                |	КонтрагентыСотрудники.Сотрудник,
		                |	КонтрагентыСотрудники.Приоритет,
		                |	КонтрагентыСотрудники.Ссылка,
		                |	Товары.Наименование,
		                |	Товары.Поставщик
						|
		                |ИЗ
		                |	Справочник.Товары КАК Товары
		                |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Контрагенты.Сотрудники КАК КонтрагентыСотрудники
		                |		ПО Товары.Поставщик = КонтрагентыСотрудники.Ссылка
						|ГДЕ КонтрагентыСотрудники.Приоритет В(
						|	ВЫБРАТЬ МАКСИМУМ(Приоритет) ИЗ Справочник.Контрагенты.Сотрудники ГДЕ Ссылка = Товары.Поставщик)"
									;
	
	РезультатЗапроса = Запрос5.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = ""+ Выборка.Наименование + " " + Выборка.Сотрудник;
		Сообщение.Сообщить();
	
	КонецЦикла
	
КонецПроцедуры

&НаКлиенте
Процедура Запрос6(Команда)
	Запрос6НаСервере();
КонецПроцедуры

&НаСервере
Процедура Запрос6НаСервере()
	Запрос6 = Новый Запрос();
	Запрос6.Текст ="ВЫБРАТЬ
	               |	Товары.Поставщик,
	               |	Товары.Цена,
	               |	Товары.Наименование
	               |ИЗ
	               |	Справочник.Товары КАК Товары
				   |ГДЕ Товары.Цена В (ВЫБРАТЬ МИНИМУМ(Цена) из Справочник.Товары ГДЕ Поставщик = Товары.Поставщик)";
	
	РезультатЗапроса = Запрос6.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = "" + Выборка.Поставщик+ " " + Выборка.Наименование;
		Сообщение.Сообщить();	
	КонецЦикла

КонецПроцедуры

