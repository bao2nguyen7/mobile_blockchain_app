import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app_blockchain/models/process.dart';
import 'package:mobile_app_blockchain/providers/user_providers.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constans.dart';
import '../../../utils/utils.dart';

class ProcessServices {
  Future<List<Process>> fetchAllProcess({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Process> processList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('${Constants.uri}/process/get-processes'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // 'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final json = jsonDecode(res.body);
          final result = json["data"];
          // print(json["data"]["products"]);
          for (int i = 0; i < result.length; i++) {
            processList.add(Process.fromJson(result[i]));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return processList;
  }

  Future<Process> fetchAllProcessTitle(
      {required BuildContext context, required String id}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Process processAll = Process(
      stageProcess: StageProcess(
        name: '',
        description: '',
        images: [],
        timeCreate: '',
      ),
      // stagePlantSeeds: StagePlantSeeds(
      //   name: '',
      //   description: '',
      // ),
      stagePlantCare: StagePlantCare(
        name: '',
        description: '',
        water: '',
        fertilizer: '',
      ),
      stageBloom: StageBloom(
        name: '',
        description: '',
      ),
      stageCover: StageCover(
        name: '',
        description: '',
      ),
      stageHarvest: StageHarvest(
        name: '',
        description: '',
        quantity: '',
      ),
      stageSell: StageSell(
        name: '',
        description: '',
        purchasingUnit: '',
      ),
    );
    try {
      http.Response res = await http
          .get(Uri.parse('${Constants.uri}/process/get-process/$id'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // 'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final json = jsonDecode(res.body);
          final result = json["data"];
          // print(result);
          // print(json["data"]["products"]);
          processAll = Process.fromJson(result);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return processAll;
  }
}
