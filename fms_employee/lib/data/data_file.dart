import 'package:flutter/material.dart';
import 'package:fms_employee/models/model_address.dart';
import 'package:fms_employee/models/model_booking.dart';
import 'package:fms_employee/models/model_card.dart';
import 'package:fms_employee/models/model_cart.dart';
import 'package:fms_employee/models/model_color.dart';
import 'package:fms_employee/models/model_dayoff.dart';
import 'package:fms_employee/models/model_popular_service.dart';
import 'package:fms_employee/models/model_salon.dart';

import '../constants/color_constant.dart';
import '../models/model_notification.dart';


class DataFile {

  static List<ModelBooking> bookingList = [
    ModelBooking("Vệ sinh sopha", "Hôm nay, 11:00 am", "booking_owner.png",
        "Tên khách hàng", "Approved", "Hôm Nay"),
    ModelBooking("Vệ sinh sopha", "Hôm nay, 08:00 am", "booking_owner1.png",
        "Tên khách hàng", "Approved", "Hôm Nay"),
    ModelBooking("Vệ sinh sopha", "Hôm nay, 07:00 am", "booking_owner2.png",
        "Tên khách hàng", "Approved", "Hôm Nay"),
    ModelBooking("Vệ sinh sopha", "ngày/tháng/năm, 06:00 am", "booking_owner3.png",
        "Tên khách hàng", "Approved", "1 Ngày Trước")
  ];

  static List<ModelSalon> salonProductList = [
    ModelSalon("hair1.png", "Vệ sinh sopha", "Vệ sinh nội thất", "1", 10.00, 0),
    ModelSalon("shaving.png", "Hàn ghế inox", "Hàn", "1", 8.00, 0),
    ModelSalon("facecare.png", "Sơn mặt bàn ghỗ", "Sơn nội thất", "1", 12.00, 0),
    ModelSalon(
        "haircolor.png", "Sơn chân bàn kim loại", "Sơn nội thất", "1", 8.00, 0),
  ];

  static List<ModelPopularService> popularServiceList = [
    ModelPopularService("wallpaper.png", "Wall Painting", "Painter"),
    ModelPopularService("barber.png", "Salon For Men", "Barber"),
    ModelPopularService("wallpaper.png", "Wall Painting", "Painter"),
    ModelPopularService("barber.png", "Salon For Men", "Barber"),
  ];

  static List<ModelCard> cardList = [
    ModelCard("paypal.svg", "Paypal", "xxxx xxxx xxxx 5416"),
    ModelCard("mastercard.svg", "Master Card", "xxxx xxxx xxxx 8624"),
    ModelCard("visa.svg", "Visa", "xxxx xxxx xxxx 4565")
  ];

  static Map<String, ModelCart> cartList = {};

  static List<ModelAddress> addressList = [
    ModelAddress("Alena Gomez",
        "3891 Ranchview Dr. Richardson, California 62639", "(907) 555-0101"),
    ModelAddress("Alena Gomez", "4140 Parker Rd. Allentown, New Mexico 31134",
        "(907) 555-0101"),
  ];

  static List<ModelColor> hairColorList = [
    ModelColor("blackhair.png", "Black", "Black Hair Color", "4.5", 6.00, 0),
    ModelColor("brownhair.png", "Brown", "Brown Hair Color", "4.5", 10.00, 0),
  ];

  static List<ModelDayOff> scheduleList = [
    ModelDayOff("booking1.png", "Cleaning", "23 April, 2022, 11:00 am", "4.3",
        20.00, "By Mendy Wilson", "Đã duyệt", 0xFFEEFCF0, success),
    ModelDayOff("booking2.png", "Painting", "22 April, 2022, 08:00 am", "4.2",
        50.00, "By Jenny Winget", "Từ chối", error.value, completed),
  ];

  static List<ModelNotification> notificationList = [
    ModelNotification(
        "Tiêu đề thông báo 1",
        "Nội dung thông báo",
        "1 giờ trước",
        "Hôm nay"),
    ModelNotification(
        "Tiêu đề thông báo 2",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus congue rutrum. Morbi malesuada eleifend eros vel malesuada. Duis sed molestie purus.",
        "1 giờ trước",
        "Hôm nay"),
    ModelNotification(
        "Tiêu đề thông báo 3",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus congue rutrum. Morbi malesuada eleifend eros vel malesuada. Duis sed molestie purus.",
        "03:00 pm",
        "1 Ngày Trước"),
    ModelNotification(
        "Tiêu đề thông báo 4",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus congue rutrum. Morbi malesuada eleifend eros vel malesuada. Duis sed molestie purus.",
        "01:00 pm",
        "1 Ngày Trước"),
  ];

}
