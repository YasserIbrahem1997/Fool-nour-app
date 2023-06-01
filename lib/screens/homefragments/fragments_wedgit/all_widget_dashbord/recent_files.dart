import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../dashbord_screen.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            // child: DataTable2(
            //   columnSpacing: defaultPadding,
            //   minWidth: 600,
            //   columns: [
            //     DataColumn(
            //       label: Text("File Name"),
            //     ),
            //     DataColumn(
            //       label: Text("Date"),
            //     ),
            //     DataColumn(
            //       label: Text("Size"),
            //     ),
            //   ],
            //   rows: List.generate(
            //     demoRecentFiles.length,
            //         (index) => recentFileDataRow(demoRecentFiles[index]),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFiles fileInfo) {
  return DataRow(
    cells: [
      // DataCell(
      //   Row(
      //     children: [
      //       SvgPicture.asset(
      //         fileInfo.icon!,
      //         height: 30,
      //         width: 30,
      //       ),
      //       Padding(
      //         padding:  EdgeInsets.symmetric(horizontal: defaultPadding),
      //         child: Text(fileInfo.title!),
      //       ),
      //     ],
      //   ),
      // ),
      // DataCell(Text(fileInfo.date!)),
      // DataCell(Text(fileInfo.size!)),
    ],
  );
}
class RecentFile {
  final String? icon, title, date, size;

  RecentFile({this.icon, this.title, this.date, this.size});
}

List demoRecentFiles = [
  RecentFile(
    icon: "assets/icons/xd_file.svg",
    title: "XD File",
    date: "01-03-2021",
    size: "3.5mb",
  ),
  RecentFile(
    icon: "assets/icons/Figma_file.svg",
    title: "Figma File",
    date: "27-02-2021",
    size: "19.0mb",
  ),
  RecentFile(
    icon: "assets/icons/doc_file.svg",
    title: "Document",
    date: "23-02-2021",
    size: "32.5mb",
  ),
  RecentFile(
    icon: "assets/icons/sound_file.svg",
    title: "Sound File",
    date: "21-02-2021",
    size: "3.5mb",
  ),
  RecentFile(
    icon: "assets/icons/media_file.svg",
    title: "Media File",
    date: "23-02-2021",
    size: "2.5gb",
  ),
  RecentFile(
    icon: "assets/icons/pdf_file.svg",
    title: "Sales PDF",
    date: "25-02-2021",
    size: "3.5mb",
  ),
  RecentFile(
    icon: "assets/icons/excle_file.svg",
    title: "Excel File",
    date: "25-02-2021",
    size: "34.5mb",
  ),
];
