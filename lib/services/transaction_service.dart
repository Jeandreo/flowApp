import 'package:dream_flow/services/api_service.dart';
import 'package:dream_flow/utils/utils.dart';

Future<void> markAsPaid(int transactionId) async {
  try {
    final response = await requestApi('${apiRoute()}/financeiro/marcar-como-pago/$transactionId');
    if (response['success']) {
      return;
    }
  } catch (error) {
    print(error);
  }
}

Future<Map<String, dynamic>> fetchTransactionDetails(int transactionId) async {
  try {
    final response = await requestApi('${apiRoute()}/financeiro/transacoes/$transactionId');
    if (response['success']) return response['transaction'];
    throw Exception('Erro ao obter detalhes da transação');
  } catch (error) {
    print(error);
    rethrow;
  }
}
