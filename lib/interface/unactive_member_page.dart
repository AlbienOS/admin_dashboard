import 'package:admin_dashboard/common/state.dart';
import 'package:admin_dashboard/constant.dart';
import 'package:admin_dashboard/helper/navigation.dart';
import 'package:admin_dashboard/interface/data_expired_recap.dart';
import 'package:admin_dashboard/provider/member_provider.dart';
import 'package:admin_dashboard/provider/membership_provider.dart';
import 'package:admin_dashboard/provider/unactive_member_provider.dart';
import 'package:admin_dashboard/interface/membership_detail.dart';
import 'package:admin_dashboard/responsive/responsive_layout.dart';
import 'package:admin_dashboard/widget/headline_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnactiveMemberPage extends StatefulWidget{
  static const routeName = '/UnactiveMemberPage';
  const UnactiveMemberPage({Key? key}) : super(key: key);

  @override
  State<UnactiveMemberPage> createState() => _UnactiveMemberPageState();
}

class _UnactiveMemberPageState extends State<UnactiveMemberPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _gender;

  @override
  void initState() {
    _gender = "Pria";
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Navigation(),
            Expanded(
              flex: 2,
              child: ChangeNotifierProvider(create: (context) => UnactiveMemberProvider(),
                child: Consumer<UnactiveMemberProvider>(
                    builder: (context, snapshot, _){
                      final memberData = snapshot.memberList;
                      var currentState = snapshot.state;
                      if (currentState == CurrentState.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (currentState == CurrentState.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Headline(text: "List Unactive Member"),
                            Expanded(
                              child: ListView.builder(
                                controller: ScrollController(),
                                itemCount: memberData.length,
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, MembershipDekstop.routeName,
                                          arguments: memberData[i].id);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: Colors.grey[200]),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      '${memberData[i].name}'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Umur             : ${memberData[i].age}'),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Jenis Kelamin    : ${memberData[i].gender}'),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'No. Handphone    : ${memberData[i].phoneNumber}'),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Alamat    : ${memberData[i].address}'),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: ChangeNotifierProvider(
                                                  create: (context) =>
                                                      MembershipProvider(
                                                          membershipId:
                                                          memberData[i].id),
                                                  child: Consumer<
                                                      MembershipProvider>(
                                                    builder:
                                                        (context, snapshot, _) {
                                                      if (snapshot.state == 1) {
                                                        final membershipData =
                                                            snapshot.membership;
                                                        return Text(
                                                            'Berlaku Sampai   : ${membershipData.endDate}');
                                                      } else {
                                                        return Text(
                                                          "Maaf, terjadi error.",
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 20,
                                                        ),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  title: Center(
                                                                    child: Text(
                                                                      'Konfirmasi',
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                        "BATAL",
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        try {
                                                                          final result =
                                                                          await Provider.of<MemberProvider>(context, listen: false).getUserDataDelete(memberData[i].id);
                                                                          if (result ==
                                                                              "success") {
                                                                            const SnackBar(
                                                                              content:
                                                                              Text(
                                                                                "Hapus Berhasil",
                                                                              ),
                                                                            );
                                                                            Navigator.pushReplacementNamed(
                                                                                context,
                                                                                ResponsiveLayout.routeName);
                                                                          }
                                                                        } catch (e) {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            const SnackBar(
                                                                              content:
                                                                              Text(
                                                                                "Maaf terjadi kesalahan",
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                        "HAPUS",
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                          // color: Theme.of(context).colorScheme.onSurface,
                                                        ),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'U P D A T E'),
                                                                  content:
                                                                  Container(
                                                                    height: 400,
                                                                    width: 300,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          10),
                                                                    ),
                                                                    child: Form(
                                                                      key:
                                                                      _formKey,
                                                                      child:
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          const Text(
                                                                            'Please Update Data Correctly!',
                                                                            style:
                                                                            TextStyle(
                                                                              fontSize:
                                                                              15,
                                                                              color:
                                                                              Colors.grey,
                                                                            ),
                                                                          ),
                                                                          NameTextField(
                                                                              nameController:
                                                                              _nameController),
                                                                          AgeTextField(
                                                                              ageController:
                                                                              _ageController),
                                                                          genderRadioButton(
                                                                              context),
                                                                          AddressTextField(
                                                                              addressController:
                                                                              _addressController),
                                                                          PhoneNumberTextField(
                                                                              phoneNumberController:
                                                                              _phoneNumberController),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                        "CANCEL",
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (_formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          try {
                                                                            final result =
                                                                            await Provider.of<MemberProvider>(context, listen: false).getUserDataUpdate(
                                                                              _nameController.text,
                                                                              int.parse(_ageController.text),
                                                                              _gender.toString(),
                                                                              _addressController.text,
                                                                              _phoneNumberController.text,
                                                                              memberData[i].id,
                                                                            );
                                                                            if (result ==
                                                                                "success") {
                                                                              const SnackBar(
                                                                                content: Text(
                                                                                  "Update Berhasil",
                                                                                ),
                                                                              );
                                                                              Navigator.pushReplacementNamed(context,
                                                                                  ResponsiveLayout.routeName);
                                                                            }
                                                                          } catch (e) {
                                                                            ScaffoldMessenger.of(context)
                                                                                .showSnackBar(
                                                                              const SnackBar(
                                                                                content: Text(
                                                                                  "Maaf terjadi kesalahan",
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                        "UPDATE",
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }else if(currentState == CurrentState.noData){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Maaf Data Tidak Tersedia.',
                            ),
                          ],
                        );
                      }else {
                        return Column(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error,
                                      size: 50, color: Theme.of(context).colorScheme.error),
                                  Text(
                                    "Maaf, terjadi error.",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    }
                ),
              ),
            ),
            // second half of page
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  // list of stuff
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DataExpiredRecap(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
  Theme genderRadioButton(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.grey),
      child: Column(
        children: [
          RadioListTile<String>(
            title: const Text('Pria'),
            value: "Pria",
            groupValue: _gender,
            onChanged: (value) {
              setState(
                    () {
                  _gender = value;
                },
              );
            },
            activeColor: Colors.blue,
          ),
          RadioListTile<String>(
            title: const Text('Wanita'),
            value: "Wanita",
            groupValue: _gender,
            onChanged: (value) {
              setState(
                    () {
                  _gender = value!;
                },
              );
            },
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
class NameTextField extends StatelessWidget {
  const NameTextField({
    Key? key,
    required TextEditingController nameController,
  })  : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextFormField(
        validator: (val) =>
        val == null || val == "" ? "Mohon untuk mengisi form ini" : null,
        keyboardType: TextInputType.name,
        controller: _nameController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Name",
        ),
      ),
    );
  }
}

class AgeTextField extends StatelessWidget {
  const AgeTextField({
    Key? key,
    required TextEditingController ageController,
  })  : _ageController = ageController,
        super(key: key);

  final TextEditingController _ageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextFormField(
        validator: (val) =>
        val == null || val == "" ? "Mohon untuk mengisi form ini" : null,
        keyboardType: TextInputType.number,
        controller: _ageController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Age",
        ),
      ),
    );
  }
}

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    Key? key,
    required TextEditingController addressController,
  })  : _addressController = addressController,
        super(key: key);

  final TextEditingController _addressController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextFormField(
        validator: (val) =>
        val == null || val == "" ? "Mohon untuk mengisi form ini" : null,
        controller: _addressController,
        keyboardType: TextInputType.streetAddress,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Address",
        ),
      ),
    );
  }
}

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    Key? key,
    required TextEditingController phoneNumberController,
  })  : _phoneNumberController = phoneNumberController,
        super(key: key);

  final TextEditingController _phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextFormField(
        validator: (val) =>
        val == null || val == "" ? "Mohon untuk mengisi form ini" : null,
        controller: _phoneNumberController,
        keyboardType: TextInputType.phone,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: "Phone Number",
        ),
      ),
    );
  }
}

