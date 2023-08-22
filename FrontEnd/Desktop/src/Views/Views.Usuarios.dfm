inherited frmUsuarios: TfrmUsuarios
  Caption = 'frmUsuarios'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 61
      Caption = 'Usu'#225'rios'
      ExplicitWidth = 61
    end
  end
  inherited PageControl: TPageControl
    ActivePage = tshVisualizar
    inherited tshVisualizar: TTabSheet
      inherited pnlVisualizar: TPanel
        inherited pnlFiltros: TPanel
          object lblPesquisaNome: TLabel
            Left = 76
            Top = 10
            Width = 30
            Height = 13
            Caption = 'Nome'
          end
          object lblPesquisaCodigo: TLabel
            Left = 10
            Top = 10
            Width = 38
            Height = 13
            Caption = 'C'#243'digo'
          end
          object edtPesquisaNome: TEdit
            Left = 76
            Top = 31
            Width = 700
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
          object edtPesquisaCodigo: TEdit
            Left = 10
            Top = 31
            Width = 60
            Height = 21
            Alignment = taRightJustify
            NumbersOnly = True
            TabOrder = 1
          end
        end
        inherited DBGrid: TDBGrid
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Title.Alignment = taCenter
              Title.Caption = 'C'#243'digo'
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME'
              Title.Caption = 'Nome'
              Width = 300
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOGIN'
              Title.Alignment = taCenter
              Title.Caption = 'Login'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STATUS'
              Title.Alignment = taCenter
              Title.Caption = 'Status'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SEXO'
              Title.Alignment = taCenter
              Title.Caption = 'Sexo'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TELEFONE'
              Title.Alignment = taCenter
              Title.Caption = 'Telefone'
              Width = 100
              Visible = True
            end>
        end
      end
    end
    inherited tshCadastro: TTabSheet
      inherited Panel2: TPanel
        inherited pnlCadastro: TPanel
          object lblCodigo: TLabel
            Left = 10
            Top = 10
            Width = 38
            Height = 13
            Caption = 'C'#243'digo'
          end
          object lblNome: TLabel
            Left = 74
            Top = 10
            Width = 30
            Height = 13
            Caption = 'Nome'
          end
          object lblLogin: TLabel
            Left = 10
            Top = 58
            Width = 29
            Height = 13
            Caption = 'Login'
          end
          object lblSenha: TLabel
            Left = 214
            Top = 58
            Width = 32
            Height = 13
            Caption = 'Senha'
          end
          object lblTelefone: TLabel
            Left = 418
            Top = 58
            Width = 44
            Height = 13
            Caption = 'Telefone'
          end
          object lblSexo: TLabel
            Left = 624
            Top = 58
            Width = 24
            Height = 13
            Caption = 'Sexo'
          end
          object edtCodigo: TDBEdit
            Left = 10
            Top = 29
            Width = 60
            Height = 21
            DataField = 'id'
            DataSource = DsCadastro
            Enabled = False
            TabOrder = 0
          end
          object edtNome: TDBEdit
            Left = 74
            Top = 29
            Width = 623
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            DataField = 'nome'
            DataSource = DsCadastro
            TabOrder = 1
          end
          object ckbStatus: TDBCheckBox
            Left = 709
            Top = 29
            Width = 66
            Height = 17
            Anchors = [akTop, akRight]
            Caption = 'Ativo?'
            DataField = 'status'
            DataSource = DsCadastro
            TabOrder = 2
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object dbtLogin: TDBEdit
            Left = 10
            Top = 77
            Width = 200
            Height = 21
            DataField = 'login'
            DataSource = DsCadastro
            TabOrder = 3
          end
          object edtSenha: TDBEdit
            Left = 214
            Top = 77
            Width = 200
            Height = 21
            DataField = 'senha'
            DataSource = DsCadastro
            PasswordChar = '*'
            TabOrder = 4
          end
          object edtTelefone: TDBEdit
            Left = 418
            Top = 77
            Width = 200
            Height = 21
            DataField = 'telefone'
            DataSource = DsCadastro
            TabOrder = 5
          end
          object cmbSexo: TComboBox
            Left = 624
            Top = 77
            Width = 150
            Height = 21
            Style = csDropDownList
            TabOrder = 6
            Items.Strings = (
              'Masculino'
              'Feminino')
          end
        end
      end
    end
  end
end
