package peasanteastern;
 
import org.jbpm.graph.def.ActionHandler;
import org.jbpm.graph.exe.ExecutionContext;

import com.openkm.bean.form.Input;

import com.openkm.api.OKMAuth;
import com.openkm.api.OKMDocument;
import com.openkm.api.OKMFolder;
 
public class Document implements ActionHandler {
  private static final long serialVersionUID = 1L;
 
  /**
   * The message member gets its value from the configuration in the 
   * processdefinition. The value is injected directly by the engine. 
   */
  String message;
 
  /**
   * A message process variable is assigned the value of the message
   * member. The process variable is created if it doesn't exist yet.
   */
  @Override
  public void execute(ExecutionContext context) throws Exception {
    context.getContextInstance().setVariable("message", message);
    String company=((com.openkm.bean.form.Input)(context.getContextInstance().getVariable("company"))).getValue();
    context.getContextInstance().setVariable("company",company);
    context.getContextInstance().setVariable("wtf",context.getContextInstance().getVariable("company").getClass().getCanonicalName());
    System.out.println("From MessageActionHandler...");
    String token = OKMAuth.getInstance().login("zKT2Gp2x3NaGYd","DNms8iJGHaA3KN");
    if (!OKMFolder.getInstance().isValid(token, "/okm:root/" + company)){
        OKMFolder.getInstance().createSimple(token, "/okm:root/" + company);
    }
  }
}


