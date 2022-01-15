package exportExcel


import com.microsoft.schemas.office.excel.CTClientData
import com.microsoft.schemas.vml.CTShape
import com.microsoft.schemas.vml.CTTextbox
import org.apache.poi.ooxml.POIXMLDocumentPart
import org.apache.poi.ss.usermodel.BorderStyle
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.HorizontalAlignment
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.xddf.usermodel.chart.*

//import org.apache.poi.ss.usermodel.*

import org.apache.poi.xssf.usermodel.*
import org.apache.xmlbeans.XmlObject

import javax.servlet.http.HttpServletResponse
import javax.xml.namespace.QName
import java.lang.reflect.Field

class ExportExcelService {
    def exportExcel(def filename, def wb, HttpServletResponse response) {
        try {
            response.contentType = "application/excel";
            response.setHeader("Content-Disposition", "attachment; filename=${filename}")
            OutputStream out = response.getOutputStream();
            wb.write(out)
            out.flush()
            out.close()
            System.out.println("EXPORT EXCEL SUCCESSFULL!!!!");
        } catch (Exception e) {
            System.out.println("ERROR EXPORT EXCEL!!!! + " + e);
            e.printStackTrace();
            return
        }

    }

    def GetFileExtension(String fname2) {
        String fileName = fname2;
        String fname = "";
        String ext = "";
        int mid = fileName.lastIndexOf(".");
        fname = fileName.substring(0, mid);
        ext = fileName.substring(mid + 1, fileName.length());
        return ext;
    }

    def getFontStyle(Workbook wb, String fontName, short fontHeight,
                     boolean bold, boolean italic,
                     HorizontalAlignment align, boolean wrapText,
                     BorderStyle borderBottom, BorderStyle borderTop,
                     BorderStyle borderLeft, BorderStyle borderRight) {
        def font = wb.createFont();
        font.setFontName(fontName ? fontName : "Times New Roman");
        font.setFontHeightInPoints(fontHeight ? fontHeight : (short) 12)
        font.setBold(bold ? bold : false)
        font.setItalic(italic ? italic : false)

        CellStyle style = wb.createCellStyle()
        style.setFont(font)
        style.setAlignment(align)
        style.setBorderBottom(borderBottom ? borderBottom : BorderStyle.NONE);
        style.setBorderTop(borderTop ? borderTop : BorderStyle.NONE)
        style.setBorderLeft(borderLeft ? borderLeft : BorderStyle.NONE)
        style.setBorderRight(borderRight ? borderRight : BorderStyle.NONE)
        style.setWrapText(wrapText ? wrapText : false)
        return style
    }

    def getFontStyle(Workbook wb, String fontName, short fontHeight, boolean bold, boolean italic, HorizontalAlignment align) {
        def font = wb.createFont();
        font.setFontName(fontName ? fontName : "Times New Roman");
        font.setFontHeightInPoints(fontHeight ? fontHeight : (short) 12)
        font.setBold(bold ? bold : false)
        font.setItalic(italic ? italic : false)
        CellStyle style = wb.createCellStyle()
        style.setFont(font)
        style.setAlignment(align)
        return style
    }

    static XSSFVMLDrawing getVMLDrawing(XSSFSheet sheet) throws Exception {
        XSSFVMLDrawing drawing = null;
        if (sheet.getCTWorksheet().getLegacyDrawing() != null) {
            String legacyDrawingId = sheet.getCTWorksheet().getLegacyDrawing().getId();
            drawing = (XSSFVMLDrawing) sheet.getRelationById(legacyDrawingId);
        } else {
            int drawingNumber = sheet.getPackagePart().getPackage()
                    .getPartsByContentType(XSSFRelation.VML_DRAWINGS.getContentType()).size() + 1;
            POIXMLDocumentPart.RelationPart rp =
                    sheet.createRelationship(XSSFRelation.VML_DRAWINGS, XSSFFactory.getInstance(), drawingNumber, false);
            drawing = rp.getDocumentPart();
            String rId = rp.getRelationship().getId();
            sheet.getCTWorksheet().addNewLegacyDrawing().setId(rId);
        }
        return drawing;
    }

    static void addCheckbox(XSSFVMLDrawing drawing,
                            int col1, int dx1, int row1, int dy1, int col2, int dx2, int row2, int dy2,
                            String label, boolean checked) throws Exception {

        String shapeTypeId = "_x0000_t201";

        Field _shapeId = XSSFVMLDrawing.class.getDeclaredField("_shapeId");
        _shapeId.setAccessible(true);
        int shapeId = (int) _shapeId.get(drawing);
        _shapeId.set(drawing, shapeId + 1);

        CTShape shape = CTShape.Factory.newInstance();
        shape.setId("_x0000_s" + shapeId);
        shape.setType("#" + shapeTypeId);
        shape.setFilled(com.microsoft.schemas.vml.STTrueFalse.F);
        shape.setStroked(com.microsoft.schemas.vml.STTrueFalse.F);
        String textboxHTML = "<div style='text-align:center'>" + "<font face=\"Times New Roman\" size=\"200\" color=\"auto\">" + label + "</font>" + "</div>"
        CTTextbox[] textboxArray = new CTTextbox[1];
        textboxArray[0] = CTTextbox.Factory.parse(textboxHTML);
        textboxArray[0].setStyle("mso-direction-alt:auto");
        textboxArray[0].setSingleclick(com.microsoft.schemas.office.office.STTrueFalse.F);
        shape.setTextboxArray(textboxArray);
        CTClientData cldata = shape.addNewClientData();
        cldata.setObjectType(com.microsoft.schemas.office.excel.STObjectType.CHECKBOX);
        cldata.addNewMoveWithCells();
        cldata.addNewSizeWithCells();
        cldata.addNewAnchor().setStringValue(
                "" + col1 + ", " + dx1 + ", " + row1 + ", " + dy1 + ", " + col2 + ", " + dx2 + ", " + row2 + ", " + dy2
        );
        cldata.addAutoFill(com.microsoft.schemas.office.excel.STTrueFalseBlank.FALSE);
        cldata.addAutoLine(com.microsoft.schemas.office.excel.STTrueFalseBlank.FALSE);
        cldata.addTextVAlign("Center");
        cldata.addNoThreeD(com.microsoft.schemas.office.excel.STTrueFalseBlank.TRUE);

        cldata.addChecked((checked) ? java.math.BigInteger.valueOf(1) : java.math.BigInteger.valueOf(0));

        Field _items = XSSFVMLDrawing.class.getDeclaredField("_items");
        _items.setAccessible(true);
        @SuppressWarnings("unchecked") //we know the problem and expect runtime error if it possibly occurs
        List<XmlObject> items = (List<XmlObject>) _items.get(drawing);

        Field _qnames = XSSFVMLDrawing.class.getDeclaredField("_qnames");
        _qnames.setAccessible(true);
        @SuppressWarnings("unchecked") //we know the problem and expect runtime error if it possibly occurs
        List<QName> qnames = (List<QName>) _qnames.get(drawing);

        items.add(shape);
        qnames.add(new QName("urn:schemas-microsoft-com:vml", "shape"))
    }

    void drawBarChart(int col1, int row1, int col2, int row2, def sheet,
                      def leftTitle, def stringArray,
                      def bottomTitle, def doubleArray) {
        XSSFDrawing drawing = sheet.createDrawingPatriarch();
        XSSFClientAnchor anchor = drawing.createAnchor(0, 0, 0, 0, col1, row1, col2, row2)

        XSSFChart chart = drawing.createChart(anchor)
        chart.setTitleText("")
        chart.setTitleOverlay(false)

        XDDFChartLegend legend = chart.getOrAddLegend()
        legend.setPosition(LegendPosition.TOP_RIGHT)

        XDDFCategoryAxis leftAxis = chart.createCategoryAxis(AxisPosition.LEFT)
        leftAxis.setTitle(leftTitle)
        XDDFValueAxis bottomAxis = chart.createValueAxis(AxisPosition.BOTTOM)
        bottomAxis.setTitle(bottomTitle)
        bottomAxis.setCrosses(AxisCrosses.AUTO_ZERO)

        XDDFDataSource<String> arrayThang = XDDFDataSourcesFactory.fromArray((String[]) stringArray)
        XDDFNumericalDataSource<Double> arrayVal = XDDFDataSourcesFactory.fromArray((Double[]) doubleArray)

        XDDFChartData data = chart.createData(ChartTypes.BAR, leftAxis, bottomAxis)
        XDDFChartData.Series series1 = data.addSeries(arrayThang, arrayVal)
        series1.setTitle(leftTitle, null);
        data.setVaryColors(true)
        chart.plot(data)
        XDDFBarChartData bar = (XDDFBarChartData) data
//                    bar.setBarDirection(BarDirection.BAR)
        bar.setBarDirection(BarDirection.COL)
    }
}
