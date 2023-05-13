//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2023 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

#Область СлужебныйПрограммныйИнтерфейс

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты
		.ДобавитьТест("Удалить")
		.ДобавитьТест("СлучайныйИНН")
		.ДобавитьТест("СлучайныйКПП");
	;
		
КонецПроцедуры

Процедура Удалить() Экспорт
	
	Ссылки = Новый Массив;
	Ссылки.Добавить(ЮТест.Данные().СоздатьЭлемент("Справочники.Банки"));
	Ссылки.Добавить(ЮТест.Данные().СоздатьДокумент("Документы.ПриходТовара"));
	Ссылки.Добавить(
		ЮТест.Данные()
			.КонструкторОбъекта("Документы.ПриходТовара")
			.Провести()
	);
	
	Для Каждого Ссылка Из Ссылки Цикл
		
		СсылкаСуществует = ПомощникТестированияВызовСервера.СсылкаСуществует(Ссылка);
		ЮТест.ОжидаетЧто(СсылкаСуществует, "Ссылка на несуществующий объект").ЭтоИстина();
		
	КонецЦикла;
	
	ЮТТестовыеДанные.Удалить(Ссылки);
	
	Для Каждого Ссылка Из Ссылки Цикл
		
		СсылкаСуществует = ПомощникТестированияВызовСервера.СсылкаСуществует(Ссылка);
		ЮТест.ОжидаетЧто(СсылкаСуществует, "Объект не удален по ссылке").ЭтоЛожь();
		
	КонецЦикла;
	
КонецПроцедуры

Процедура СлучайныйИНН() Экспорт

	ИННФизическогоЛица = Истина;
	КодРегиона = "34";
	СлучайныйИНН = ЮТТестовыеДанные.СлучайныйИНН(КодРегиона, ИННФизическогоЛица);
	ЮТест.ОжидаетЧто(СлучайныйИНН).ИмеетТип("Строка").ИмеетДлину(12).НачинаетсяС("34");

	СлучайныйИНН = ЮТТестовыеДанные.СлучайныйИНН();
	ЮТест.ОжидаетЧто(СлучайныйИНН).ИмеетТип("Строка").ИмеетДлину(10);

КонецПроцедуры

Процедура СлучайныйКПП() Экспорт

	СлучайныйКПП = ЮТТестовыеДанные.СлучайныйКПП();
	ЮТест.ОжидаетЧто(СлучайныйКПП).ИмеетТип("Строка").ИмеетДлину(9);	

	
	Причина = 2;
	СлучайныйКПП = ЮТТестовыеДанные.СлучайныйКПП(, Причина);
	ЮТест.ОжидаетЧто(СлучайныйКПП).ИмеетТип("Строка").ИмеетДлину(9).Содержит("43");	

	КодНалоговогоОргана = "3444";
	Причина = 1;
	СлучайныйКПП = ЮТТестовыеДанные.СлучайныйКПП(КодНалоговогоОргана, Причина);
	ЮТест.ОжидаетЧто(СлучайныйКПП).ИмеетТип("Строка").ИмеетДлину(9).НачинаетсяС("344401");	
КонецПроцедуры

#КонецОбласти

